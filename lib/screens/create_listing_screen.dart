import 'package:devbid/theme/app_theme.dart';
import 'package:devbid/widgets/app_button.dart';
import 'package:devbid/widgets/app_input_field.dart';
import 'package:devbid/widgets/devbid_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/listing_service.dart';

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({super.key});
  static const routeName = '/create-listing';

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  int _step = 0;
  int _category = 0;
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  String _projectType = 'Mobile App';

  final _frontendController = TextEditingController();
  final _backendController = TextEditingController();
  final _databaseController = TextEditingController();
  final _apisController = TextEditingController();
  final _hostingController = TextEditingController();
  final _techStackController = TextEditingController();

  final _githubController = TextEditingController();
  final _gitlabController = TextEditingController();
  final _bitbucketController = TextEditingController();
  bool _privateRepoTransfer = false;

  final _revenueController = TextEditingController();
  final _monthlyUsersController = TextEditingController();
  final _downloadsController = TextEditingController();
  final _activeCustomersController = TextEditingController();
  final _monetizationController = TextEditingController();

  final _liveWebsiteController = TextEditingController();
  final _demoVideoController = TextEditingController();
  final _screenshotsController = TextEditingController();

  final _priceController = TextEditingController();

  bool _includeSourceCode = true;
  bool _includeGitRepo = true;
  bool _githubTransfer = true;
  bool _documentationIncluded = true;
  bool _setupGuide = true;
  bool _deploymentGuide = true;
  bool _licenseIncluded = true;

  bool _assetSourceCode = true;
  bool _assetUiUx = false;
  bool _assetFigma = false;
  bool _assetDbScripts = true;
  bool _assetApiDocs = true;
  bool _assetDomain = false;
  bool _assetHosting = false;
  bool _assetPlayStore = false;
  bool _assetAppStore = false;

  bool _confirmOwnership = false;
  bool _confirmTransferRights = false;
  bool _confirmAccuracy = false;

  @override
  void dispose() {
    _titleController.dispose();
    _shortDescriptionController.dispose();
    _frontendController.dispose();
    _backendController.dispose();
    _databaseController.dispose();
    _apisController.dispose();
    _hostingController.dispose();
    _techStackController.dispose();
    _githubController.dispose();
    _gitlabController.dispose();
    _bitbucketController.dispose();
    _revenueController.dispose();
    _monthlyUsersController.dispose();
    _downloadsController.dispose();
    _activeCustomersController.dispose();
    _monetizationController.dispose();
    _liveWebsiteController.dispose();
    _demoVideoController.dispose();
    _screenshotsController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canContinue = _canContinueCurrentStep();
    return Scaffold(
      bottomNavigationBar: const DevBidBottomNav(currentIndex: 2),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            decoration: BoxDecoration(
              color: AppColors.surfaceFor(context),
              border: Border(bottom: BorderSide(color: AppColors.borderFor(context))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 12),
                    Text('Create Listing', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(
                    5,
                    (i) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 6),
                        height: 4,
                        decoration: BoxDecoration(
                          color: i <= _step ? AppColors.primary : AppColors.border,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Step ${_step + 1} of 5', style: TextStyle(color: AppColors.secondaryTextFor(context))),
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: _buildStepContent(),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceFor(context),
              border: Border(top: BorderSide(color: AppColors.borderFor(context))),
            ),
            child: Row(
              children: [
                if (_step > 0)
                  Expanded(
                    child: AppButton(
                      text: 'Back',
                      isSecondary: true,
                      onPressed: () => setState(() => _step -= 1),
                    ),
                  ),
                if (_step > 0) const SizedBox(width: 10),
                Expanded(
                  child: AppButton(
                    text: _step == 4 ? 'Publish Listing' : 'Continue',
                    isEnabled: canContinue,
                    onPressed: () {
                      if (_step < 4) {
                        setState(() => _step += 1);
                      } else {
                        _publishListing(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    const categories = ['SaaS', 'Mobile Apps', 'AI Products', 'Developer Tools', 'Web Platforms', 'E-Commerce'];
    const projectTypes = ['Mobile App', 'SaaS', 'Website', 'AI Tool', 'API', 'Other'];
    if (_step == 0) {
      const icons = [
        Icons.cloud_outlined,
        Icons.phone_android_outlined,
        Icons.auto_awesome_outlined,
        Icons.code_outlined,
        Icons.language_outlined,
        Icons.shopping_bag_outlined,
      ];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Project Details', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Basic information and project type', style: TextStyle(color: AppColors.secondaryTextFor(context))),
          const SizedBox(height: 16),
          AppInputField(
            label: 'Project Title *',
            controller: _titleController,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _shortDescriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Short Description *',
              hintText: 'Describe core value, users and business context.',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          const Text('Category *', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 96,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (_, i) => InkWell(
              onTap: () => setState(() => _category = i),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceFor(context),
                  borderRadius: AppRadius.md,
                  border: Border.all(color: _category == i ? AppColors.primary : AppColors.borderFor(context)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[i], color: AppColors.primary),
                    const SizedBox(height: 6),
                    Text(categories[i], style: const TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _projectType,
            decoration: const InputDecoration(labelText: 'Project Type *'),
            items: projectTypes.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _projectType = value);
              }
            },
          ),
        ],
      );
    }
    if (_step == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Technical & Source Information', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Technology stack and repository transfer details', style: TextStyle(color: AppColors.secondaryTextFor(context))),
          const SizedBox(height: 16),
          AppInputField(label: 'Frontend Technology', controller: _frontendController),
          const SizedBox(height: 12),
          AppInputField(label: 'Backend Technology', controller: _backendController),
          const SizedBox(height: 12),
          AppInputField(label: 'Database Used', controller: _databaseController),
          const SizedBox(height: 12),
          AppInputField(label: 'APIs Used', controller: _apisController),
          const SizedBox(height: 12),
          AppInputField(label: 'Hosting Provider', controller: _hostingController),
          const SizedBox(height: 12),
          AppInputField(label: 'Tech Stack (comma separated) *', controller: _techStackController, onChanged: (_) => setState(() {})),
          const SizedBox(height: 16),
          const Text('Source Code Information', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _checkboxTile('Complete Source Code Included', _includeSourceCode, (v) => setState(() => _includeSourceCode = v)),
          _checkboxTile('Git Repository Included', _includeGitRepo, (v) => setState(() => _includeGitRepo = v)),
          _checkboxTile('GitHub Ownership Transfer Available', _githubTransfer, (v) => setState(() => _githubTransfer = v)),
          _checkboxTile('Documentation Included', _documentationIncluded, (v) => setState(() => _documentationIncluded = v)),
          _checkboxTile('Setup Guide Included', _setupGuide, (v) => setState(() => _setupGuide = v)),
          _checkboxTile('Deployment Guide Included', _deploymentGuide, (v) => setState(() => _deploymentGuide = v)),
          _checkboxTile('License Included', _licenseIncluded, (v) => setState(() => _licenseIncluded = v)),
          const SizedBox(height: 12),
          AppInputField(label: 'GitHub Repository URL', controller: _githubController),
          const SizedBox(height: 12),
          AppInputField(label: 'GitLab Repository URL', controller: _gitlabController),
          const SizedBox(height: 12),
          AppInputField(label: 'Bitbucket URL', controller: _bitbucketController),
          _checkboxTile('Private Repository Transfer Available', _privateRepoTransfer, (v) => setState(() => _privateRepoTransfer = v)),
        ],
      );
    }
    if (_step == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Assets & Business Information', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Included assets, revenue and customer metrics', style: TextStyle(color: AppColors.secondaryTextFor(context))),
          const SizedBox(height: 16),
          const Text('Assets Included', style: TextStyle(fontWeight: FontWeight.w700)),
          _checkboxTile('Source Code', _assetSourceCode, (v) => setState(() => _assetSourceCode = v)),
          _checkboxTile('UI/UX Files', _assetUiUx, (v) => setState(() => _assetUiUx = v)),
          _checkboxTile('Figma Design', _assetFigma, (v) => setState(() => _assetFigma = v)),
          _checkboxTile('Database Scripts', _assetDbScripts, (v) => setState(() => _assetDbScripts = v)),
          _checkboxTile('API Documentation', _assetApiDocs, (v) => setState(() => _assetApiDocs = v)),
          _checkboxTile('Domain Included', _assetDomain, (v) => setState(() => _assetDomain = v)),
          _checkboxTile('Hosting Included', _assetHosting, (v) => setState(() => _assetHosting = v)),
          _checkboxTile('Play Store Account Included', _assetPlayStore, (v) => setState(() => _assetPlayStore = v)),
          _checkboxTile('App Store Account Included', _assetAppStore, (v) => setState(() => _assetAppStore = v)),
          const SizedBox(height: 16),
          AppInputField(label: 'Revenue Generated', controller: _revenueController),
          const SizedBox(height: 12),
          AppInputField(label: 'Monthly Users', controller: _monthlyUsersController),
          const SizedBox(height: 12),
          AppInputField(label: 'Downloads', controller: _downloadsController),
          const SizedBox(height: 12),
          AppInputField(label: 'Active Customers', controller: _activeCustomersController),
          const SizedBox(height: 12),
          AppInputField(label: 'Monetization Method', controller: _monetizationController),
        ],
      );
    }
    if (_step == 3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Demo & Pricing', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text('Public proof and transaction pricing', style: TextStyle(color: AppColors.secondaryTextFor(context))),
          const SizedBox(height: 16),
          AppInputField(label: 'Live Website URL', controller: _liveWebsiteController),
          const SizedBox(height: 12),
          AppInputField(label: 'Demo Video URL', controller: _demoVideoController),
          const SizedBox(height: 12),
          AppInputField(label: 'Screenshots Upload Links', controller: _screenshotsController),
          const SizedBox(height: 16),
          AppInputField(label: 'Price (INR) *', controller: _priceController, onChanged: (_) => setState(() {})),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Verification', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text('Trust declarations required before publishing', style: TextStyle(color: AppColors.secondaryTextFor(context))),
        const SizedBox(height: 16),
        _checkboxTile('I own this project', _confirmOwnership, (v) => setState(() => _confirmOwnership = v)),
        _checkboxTile('I have rights to transfer ownership', _confirmTransferRights, (v) => setState(() => _confirmTransferRights = v)),
        _checkboxTile('The project description is accurate', _confirmAccuracy, (v) => setState(() => _confirmAccuracy = v)),
        const SizedBox(height: 18),
        const _TipsCard(),
      ],
    );
  }

  void _publishListing(BuildContext context) {
    final title = _titleController.text.trim();
    final description = _shortDescriptionController.text.trim();
    final price = double.tryParse(_priceController.text.trim());
    const categories = ['SaaS', 'Mobile Apps', 'AI Products', 'Developer Tools', 'Web Platforms', 'E-Commerce'];

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Project title is required')));
      setState(() => _step = 0);
      return;
    }
    if (description.length < 50) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Description must be at least 50 characters')));
      setState(() => _step = 0);
      return;
    }
    if (price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid price')));
      setState(() => _step = 2);
      return;
    }

    if (!_confirmOwnership || !_confirmTransferRights || !_confirmAccuracy) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please complete all verification confirmations')));
      setState(() => _step = 4);
      return;
    }

    context.read<ListingService>().addListing(
          title: title,
          category: categories[_category],
          price: price,
          description: description,
          imageUrl: _liveWebsiteController.text.trim(),
        );

    _titleController.clear();
    _shortDescriptionController.clear();
    _priceController.clear();
    _liveWebsiteController.clear();
    _techStackController.clear();
    _confirmOwnership = false;
    _confirmTransferRights = false;
    _confirmAccuracy = false;
    setState(() => _step = 0);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Project uploaded successfully')));
  }

  bool _canContinueCurrentStep() {
    if (_step == 0) {
      return _titleController.text.trim().isNotEmpty && _shortDescriptionController.text.trim().length >= 50;
    }
    if (_step == 1) {
      return _techStackController.text.trim().isNotEmpty;
    }
    if (_step == 3) {
      final price = double.tryParse(_priceController.text.trim());
      return price != null && price > 0;
    }
    if (_step == 4) {
      return _confirmOwnership && _confirmTransferRights && _confirmAccuracy;
    }
    return true;
  }

  Widget _checkboxTile(String title, bool value, ValueChanged<bool> onChanged) {
    return CheckboxListTile(
      value: value,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      onChanged: (newValue) => onChanged(newValue ?? false),
    );
  }
}

class _TipsCard extends StatelessWidget {
  const _TipsCard();
  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF03334A) : const Color(0xFFE8F8FF),
        borderRadius: AppRadius.md,
        border: Border.all(color: isDark ? const Color(0xFF05688F) : const Color(0xFFAFDBEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pricing Tips', style: TextStyle(color: isDark ? AppColors.cyan : AppColors.primary, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('• Research similar projects on DevBid', style: TextStyle(color: AppColors.isDark(context) ? null : AppColors.lightText)),
          Text('• Consider your project\'s revenue and user base', style: TextStyle(color: AppColors.isDark(context) ? null : AppColors.lightText)),
          Text('• Factor in code quality and documentation', style: TextStyle(color: AppColors.isDark(context) ? null : AppColors.lightText)),
        ],
      ),
    );
  }
}

